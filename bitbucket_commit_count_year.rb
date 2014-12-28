#!/usr/bin/env ruby
# Thanks to https://github.com/vongrippen/bitbucket
# gem install bitbucket_rest_api

gem 'bitbucket_rest_api'

require 'net/http'
require 'bitbucket_rest_api'
require 'json'

# This job will count the commits of a all your bitbucket projects

# Config
bitbucket_repo_username = ""
bitbucket_username = ""
bitbucket_password = ""
bitbucket_year = "2015"

# Script
bitbucket = BitBucket.new :basic_auth => "#{bitbucket_username}:#{bitbucket_password}"

# Function
def getCommitCount (bitbucket, username, date_start)
	commit_count = 0
	commit_count_total = 0
	
	bitbucket.repos.list do |repo|
		puts repo.slug
		
		commit_count_repo = 0
		
		begin
	
		all_changesets = bitbucket.repos.changesets.all username, repo.slug

		all_changesets.changesets.each do |changeset|
			puts "--> #{changeset.node} (#{changeset.timestamp}, #{changeset.timestamp[0, 4]})"
		
			puts changeset.timestamp.inspect
		
			commit_count_total = commit_count_total + 1
			commit_count_repo = commit_count_repo + 1
			
			if changeset.has_key?("timestamp") && changeset.timestamp[0, 4] == date_start 
				commit_count = commit_count + 1
			end
		end
		
		
		puts "--> commit_count: #{commit_count}"
		puts "--> commit_count_repo: #{commit_count_repo}"
		puts "--> commit_count_total: #{commit_count_total}"
		puts ""
		rescue 
		end
	end
 
	return commit_count
end

#getCommitCount(bitbucket, bitbucket_repo_username, bitbucket_year)

SCHEDULER.every '5m', :first_in => 0 do |job|
	count = getCommitCount(bitbucket, bitbucket_repo_username, bitbucket_year)
 
	send_event('bitbucket_commit_count_year', current: count)
end