# ngbase
This is a typical setup that I use for vagrant-oriented development.
See the documentation for [Vagrant](https://www.vagrantup.com/) and
[VirtualBox](https://www.virtualbox.org/) to establish
prerequisites.

This setup includes a provisioning script (bootstrap.sh)
that installs common libraries and frameworks
that I use, especially node and javascript development tools.
This setup installs frameworks and libraries for Angular projects.
I have a similar setup for React projects.

###npm
The provisioning script has special handling for setting up npm with
an alternate target folder for installing global packages. The setup
follows one of the strategies recommended in 
npm's [documentation](https://docs.npmjs.com/getting-started/fixing-npm-permissions).
After setting up the alternate folder for global npm packages, a
child script (bootstrap-npm.sh) is invoked to execute as the
vagrant user to perform the global installs.

###Unison
This configuration uses [Unison](https://www.cis.upenn.edu/~bcpierce/unison/) for file synchronization between
the host and the virtual machine. This is my preferred file sync
technique when working with vagrant. It provides very good
performance. However, it requires extra care to ensure that the
version of Unison installed in the virtual machine is compatible
with the version installed on the host. Specifically, the versions
of OCaml, compiled into Unison must match.

There is a script (setup-unison.sh) that will create a unison profile
that can be used to launch file synchronization.

###Firewall
The Vagrant file and the provisioning script include coordinated
configuration of firewalls. This includes ports for HTTP as well as
typical ports used when developing with node, including debug ports.

###Usage
I use this within [WebStorm](https://www.jetbrains.com/webstorm/), leveraging
its built-in [support for vagrant](https://www.jetbrains.com/help/webstorm/vagrant-working-with-reproducible-development-environments.html).
However, you can use it with just a few terminal windows.

First, start the virtual machine with **vagrant up**. On the first
time, the provisioning script will be invoked and take some time to 
execute. After the first time, **vagrant up** will not take long
to start the virtual machine.

Next, open a shell and connect to the virtual machine with **vagrant ssh**.

Lastly, open a second shell and start file synchronization with **unison ngbase**.
Of course, if you modify **setup-unison.sh** with a different project
name, the command will be **unison your-project-name**.

The key to working in this type of environment is to remember you
work with source code (edit, lint, git, etc) on the host. And, you build
and execute (gulp, npm install, node, nodemon, etc) in
the virtual machine.

####WebStorm
To use with [WebStorm](https://www.jetbrains.com/webstorm/):

 * I use the **Tools/Vagrant/Up** menu to bring up the virtual machine.
 * I create an external tool configuration to start the **Unison project-name** command. Unison's activity will be
 logged in the **Run** docked panel.
 * I work with source code within WebStorm (edit, git).
 * I use the **Tools/Start SSH Session** menu to open an SSH session on the virtual machine.