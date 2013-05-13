#!/usr/bin/env ruby
# encoding: UTF-8
require 'find'
# Emma

pwd = File.dirname(__FILE__)

@CRFPP  = ENV['CRFPP_HOME'] ? "#{ENV['CRFPP_HOME']}/bin" : "#{pwd}/../../crfpp"
@SRC    = "#{pwd}/genericSect"
@DATA   = "#{pwd}/../../resources/sectLabel/"
@TEST_DIR = ENV['PARSCIT_TMPDIR'] || "/tmp"

require "#{@SRC}/forceUtf8"

name  = "#{Time.now.to_i}-#{Process.pid}"

cmd = "ruby #{@SRC}/extractFeature.rb #{ARGV[0]} > #{@TEST_DIR}/#{name}.test"
system(cmd)

cmd = "#{@CRFPP}/crf_test -m #{@DATA}/genericSect.model  #{@TEST_DIR}/#{name}.test >  #{@TEST_DIR}/#{name}.out"
system(cmd)


if ARGV[1] != nil
	g = File.open("#{ARGV[1]}", "w")

	cmd = "chmod 777 #{ARGV[1]}"
	system(cmd)
end

f = File.open("#{@TEST_DIR}/#{name}.out")
while !f.eof do
	str = force_utf8!(f.gets).chomp.strip
	if str != ""
		l = str.split(" ")
		output = l.at(l.length-1)
		while output.index("-") != nil
			output = output.sub("-", " ")
		end
		if output == "related works"
			output = "related work"
		end
		if ARGV[1] == nil
			puts "#{output}"
		else
			g.write("#{output}\n")
		end
	end
end
f.close
if ARGV[1] != nil
	g.close
end

File.unlink("#{@TEST_DIR}/#{name}.out")
File.unlink("#{@TEST_DIR}/#{name}.test")
