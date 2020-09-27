#!/bin/bash
# Copyright (c) 2000-2016 Synology Inc. All rights reserved.

source /pkgscripts/include/pkg_util.sh

UISTRING_PATH="/source/Mangatheque-Synology/package/ui/texts"
# Avec la version 6.1, la description et le nom sont obligatoires et ne peuvent plus être construit à partir des fichiers de traduction.
displayname=mangatheque

package="mangatheque"

version="0.0.0001"

maintainer="ShooterDev"

maintainer_url="http://shooterdev.fr"

distributor="ShooterDev"

support_url="http://shooterdev.fr"

arch="$(pkg_get_platform)"

dsmuidir="ui"

dsmappname="SYNO.SDS.MANGATHEQUE"

install_dep_services="nginx pgsql"

install_dep_packages="PythonModule"

start_dep_services="nginx pgsql" 

thirdparty = "yes" 

support_conf_folder = "yes"

description="Gestion d'une Mangatheque pour les Utilisateurs du Super Serveur Synology"
[ "$(caller)" != "0 NULL" ] && return 0

pkg_dump_info
