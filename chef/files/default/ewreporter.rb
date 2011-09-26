#
# Cookbook Name:: chef
# Recipe:: ewreporter
#
# Copyright 2011, Evolving Web, Inc.
#


# This report Handler makes an alternative CSV log file.
# The CSV log file will be used by a Nagios monitoring script.

require 'rubygems'
require 'date'
 
module EvolvingWeb
  class SimpleLog < Chef::Handler
    def report
      if run_status.success?
        msg = "Great success!"
      else
        msg = "Fail!"
      end
      csv_msg = format_csv_report(msg)
      File.open("#{node[:chef][:log_dir]}/simple.log", 'a') {|f| f.write(csv_msg)}
    end

    def format_csv_report(message)
      date = DateTime::now()
      duration = run_status.elapsed_time
      return "\"#{date}\",\"#{duration}\",\"#{message}\"\n"
    end
  end
end
