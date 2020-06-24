__Important note__: This repo has been cloned from a different repo and adjusted based on my preferences. For nwneal's original (low battery notifications) repo, go [here](https://github.com/nwneal/Ubuntu-16-battery-notification).

# Ubuntu 18 Battery Life Notification
A script that will notify you to plug in or unplug your adapter for battery preservation on Ubuntu 18.

## Setup

To setup this script, you will need to clone the repo, and go into the directory on your computer.

After that, run the following commands:

	chmod u+x battery-notification.sh

	./battery-notification.sh --install

What these commands will do is set the shell script to executable by the user, and install the script.

The script will install the script to a 'bin' directory in your home directory.

Then, it will install a cron job to call it every 2 minutes.

## Output

* When your battery is above 80%, it will tell you to unplug your computer.

* When your battery is between 40-20%, it will alert you to plug in your adapter.

* Below 20% it will urge you to plug in your adapter.

## Uninstall

To uninstall this script , delete the line that calls '*bn.sh*' from your crontab, and delete the bn.sh script from your '~/bin' directory.


