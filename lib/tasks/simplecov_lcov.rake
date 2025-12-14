# lib/tasks/simplecov_lcov.rake
# Provides a `rake simplecov-lcov[output_path]` task to generate an LCOV
# report from SimpleCov's `.resultset.json` output. The CI workflow expects
# a `simplecov-lcov` rake task, but the simplecov-lcov gem does not ship a
# Rake task by default, so we add a small, robust implementation here.

require 'json'
require 'fileutils'

desc 'Generate LCOV report from SimpleCov results: rake simplecov-lcov[coverage/lcov.info]'
task :'simplecov-lcov', [:output] do |_t, args|
  output = args[:output] || 'coverage/lcov.info'

  resultset_path = File.join('coverage', '.resultset.json')
  unless File.exist?(resultset_path)
    warn "[simplecov-lcov] No resultset found at #{resultset_path}; run your tests with SimpleCov first."
    next
  end

  begin
    require 'simplecov'
    require 'simplecov-lcov'
  rescue LoadError => e
    warn "[simplecov-lcov] Required gem missing: #{e.message}"
    next
  end

  data = JSON.parse(File.read(resultset_path))
  # Pick the first suite's coverage. This mirrors how many CI setups run a
  # single test suite (RSpec). If multiple suites exist, the first one wins.
  suite = data.values.first
  coverage_hash = suite && suite['coverage']

  unless coverage_hash && !coverage_hash.empty?
    warn '[simplecov-lcov] No coverage data found in resultset; skipping.'
    next
  end

  # Build a SimpleCov::Result and format it with the LcovFormatter
  result = SimpleCov::Result.new(coverage_hash)
  formatter = SimpleCov::Formatter::LcovFormatter.new

  lcov = formatter.format(result)

  if lcov && !lcov.empty?
    FileUtils.mkdir_p(File.dirname(output))
    File.write(output, lcov)
    puts "[simplecov-lcov] Wrote LCOV to #{output}"
  else
    # Some versions of the formatter may write files directly; check for
      # default path 'coverage/lcov' (no extension) as a fallback. If it's a
      # directory with per-file lcov outputs, concatenate them into a single
      # output file.
      fallback = File.join('coverage', 'lcov')
      if File.exist?(fallback)
        if File.directory?(fallback)
          entries = Dir[File.join(fallback, '*.lcov')].sort
          if entries.any?
            FileUtils.mkdir_p(File.dirname(output))
            File.open(output, 'w') do |outf|
              entries.each do |f|
                outf.write(File.read(f))
                outf.write("\n")
              end
            end
            puts "[simplecov-lcov] Concatenated #{entries.size} lcov files to #{output}"
          else
            warn "[simplecov-lcov] Found directory #{fallback} but no .lcov files inside"
          end
        else
          FileUtils.mv(fallback, output)
          puts "[simplecov-lcov] Moved #{fallback} to #{output}"
        end
      else
        warn '[simplecov-lcov] Formatter produced no output; please check gem compatibility.'
      end
end

end
