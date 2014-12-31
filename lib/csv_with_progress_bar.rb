require 'csv'
require 'progress_bar'

# Neat way to wrap CSV in a progress bar on the command line
# H/T http://www.51degrees.net/2012/10/23/progress-bars-for-ruby-csv.html
class CSV
  module ProgressBar
    def progress_bar
      ::ProgressBar.new(@io.size, :bar, :percentage, :elapsed, :eta)
    end

    def each
      progress_bar = self.progress_bar

      super do |row|
        yield row
        progress_bar.count = self.pos
        progress_bar.increment!(0)
      end
    end
  end

  class WithProgressBar < CSV
    include ProgressBar
  end

  def self.with_progress_bar
    WithProgressBar
  end
end
