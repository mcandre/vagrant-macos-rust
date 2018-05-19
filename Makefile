BOX_NAMESPACE=mcandre
BOX_BASENAME=vagrant-macos-rust

.PHONY: launch-vm clean-vm clean-boxes clean-vagrant-metadata

launch-vm-virtualbox: Vagrantfile bootstrap.sh
	vagrant up --provider virtualbox

launch-vm-vmware: Vagrantfile bootstrap.sh
	vagrant up --provider vmware_desktop

clean-vm:
	-vagrant destroy -f

clean-boxes:
	-rm *.box

clean-vagrant-metadata:
	-rm -rf .vagrant

clean: clean-boxes clean-vm clean-vagrant-metadata

boxes: $(BOX_BASENAME)-virtualbox.box $(BOX_BASENAME)-vmware.box

$(BOX_BASENAME)-virtualbox.box: clean-boxes clean-vm launch-vm-virtualbox export.Vagrantfile
	vagrant package --output $(BOX_BASENAME)-virtualbox.box --vagrantfile export.Vagrantfile

$(BOX_BASENAME)-vmware.box: clean-boxes clean-vm launch-vm-vmware export.Vagrantfile
	vagrant package-vmware --output $(BOX_BASENAME)-vmware.box --vagrantfile export.Vagrantfile

import: import-virtualbox import-vmware

import-virtualbox: $(BOX_BASENAME)-virtualbox.box
	vagrant box add --force --name $(BOX_NAMESPACE)/$(BOX_BASENAME) $(BOX_BASENAME)-virtualbox.box

import-vmware: $(BOX_BASENAME)-vmware.box
	vagrant box add --force --name $(BOX_NAMESPACE)/$(BOX_BASENAME) $(BOX_BASENAME)-vmware.box
