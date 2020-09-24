#!/bin/bash
# Copyright (c) 2000-2016 Synology Inc. All rights reserved.

source /pkgscripts/include/pkg_util.sh

UISTRING_PATH="/source/Mangatheque-Synology/package/ui/texts"
# Avec la version 6.1, la description et le nom sont obligatoires et ne peuvent plus être construit à partir des fichiers de traduction.
displayname=mangatheque
description="Gestion d'une Mangatheque pour les utilisateurs du serveur Synology"

package="mangatheque"
version="0.0.0001"
maintainer="ShooterDev"
arch="$(pkg_get_platform)"

dsmuidir="ui"
dsmappname="SYNOCOMMUNITY.sl.AppInstance"

thirdparty="yes"

install_dep_services="nginx pgsql"
install_dep_packages="PythonModule"
start_dep_services="nginx pgsql"

[ "$(caller)" != "0 NULL" ] && return 0
pkg_dump_info
