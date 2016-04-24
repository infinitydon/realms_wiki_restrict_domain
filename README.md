# realms_wiki_restrict_domain

This setup is used to create a wiki frontend application based on wiki-realms.

The following should be done after the docker image is buitl from the Dockerfile:

1.) On the host system that is running the docker engine, clone the wiki git that needs a local frontend application for maintaining it.

2.) There are 2 scripts for updating the remote repo sync.sh and sync_expect.sh (this will supply the credentials for the remote server, it also initiates the sync.sh script). 

synch_expect.sh should be editied to suit the remote repo credentials, then it should be placed in crontab to run every minutes:

*/1 * * * * /path_to_folder/sync_expect.sh

3.) Docker image should be built from the dockerfile by cloning this git (realms_wiki_restrict_domain):
    docker build -t "realms-wiki:dockerfile" .
    realms-wiki.json should be editied with the appropriate key and secret from Google API OAuth settings
Then run the docker image, the cloned wiki folder in step 1 should be mapped to a volume on the docker image
    docker run -v /home/user/remote_wiki:/wikidata /home/user/realms_wiki_restrict_domain/realms-wiki.json:/etc/realms-wiki/realms-wiki.json -p 5000:5000 realms-wiki:dockerfile
    
4.) Login to docker image and edit /home/deploy/realms-wiki/.venv/lib/python2.7/site-packages/realms/modules/auth/oauth/models.py to restrict the domain name for users (Google OAuth is used for this purpose), go to following line:

authorize_url='https://accounts.google.com/o/oauth2/auth?hd=domain_name',

Modify domain_name to your domain. Then save and restart the container.

Point your browser to http://ip_address_local_system:5000


