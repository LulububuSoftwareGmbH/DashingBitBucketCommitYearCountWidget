## Description

Simple [Dashing](http://shopify.github.com/dashing) job to display the commit counts of a specific year of all [Bitbucket](https://bitbucket.org) repositories. Uses [Bitbucket's API](https://confluence.atlassian.com/display/BITBUCKET/Using+the+Bitbucket+REST+APIs).
Inspired by [jeroenbegyn's](https://gist.github.com/jeroenbegyn) [Bitbucket followers job for Dashing](https://gist.github.com/jeroenbegyn/5385092). Also it uses [vongrippen's](https://github.com/vongrippen) [BitBucketAPI](https://github.com/vongrippen/bitbucket), thanks for this!



##Usage

To use this widget put the `bitbucket_commit_count_year.rb` file in your `/jobs` folder.

To include the widget in a dashboard, add the following snippets to the dashboard layout file:
    
    <li data-row="1" data-col="2" data-sizex="1" data-sizey="1">
      <div data-id="bitbucket_commit_count_year" data-view="Number" data-title="Bitbucket commits this year"></div>
    </li>

##Settings

You'll need to add the Bitbucket username or the team name you want to count the commits of. Also you need to pass a username and a password since I am not able to getting the oauth stuff work... The year filter is a simple "starts with" check, so theoretically you can commits per month or day, too.

The commits are fetched every 5 minutes, but you can change that by editing the job schedule.

