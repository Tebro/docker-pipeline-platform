# Docker Pipeline Platform

This is a small project that helps when creating a Docker platform on your laptop.

The components used are : Rancher, Gogs and Drone.


### Requirements

The script provided requires you to have the Docker Toolbox installed. (Windows/OS X)

On linux you need to install the components manually. You need:

 - Docker Machine
 - Docker Compose
 - Virtualbox



### Usage

Run the up.sh script provided in this repository.

```
./up.sh
```

The script outputs the URLs to the various systems at the end.

**Note:** For Gogs, the first account that registers is given admin rights.

The script starts one VM that runs all of the platform services. And another that you can add as a compute node to Rancher by following the steps below:

- Open the Rancher Web UI.
- In the middle of the screen it tells you that you need to add a host. Click the button.
- The next screen asks you to confirm the URL to Rancher, the default should be the same you browsed to, and that is what it needs to be. Click Save
- Make sure the "Custom" box is selected on the top row
- At step 3 you can add labels if you wish
- Step 4 is not needed for this setup
- Copy the command from step 5
- Open a terminal and SSH into the Compute Node with `docker-machine ssh node`
- Paste the command you copied from Rancher and the Node will join the cluster


After this you are done, you can now create git projects, push them to Gogs, have Drone perform tests on your code. If you want to use Drone to automatically deploy your projects to Rancher you need to have Drone build and push Docker images to the docker hub so that Rancher can pull them from there.


### Destroying the platfrom

When you want to tear down the platform all you need to do is run the down.sh script that is provided. (`./down.sh`)
