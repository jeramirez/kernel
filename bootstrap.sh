#!/bin/sh
#
# This file should remain OS independent
#
# $Id: bootstrap.sh,v 1.6 2012/11/27 00:49:04 phil Exp $
#
# @Copyright@
# 
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 6.2 (SideWinder)
# 		         version 7.0 (Manzanita)
# 
# Copyright (c) 2000 - 2017 The Regents of the University of California.
# All rights reserved.	
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided 
# with the distribution.
# 
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement: 
# 
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
# 
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of 
# the associated name, interested parties should contact Technology 
# Transfer & Intellectual Property Services, University of California, 
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910, 
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
# 
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# @Copyright@
#
# $Log: bootstrap.sh,v $
# Revision 1.6  2012/11/27 00:49:04  phil
# Copyright Storm for Emerald Boa
#
# Revision 1.5  2012/05/06 05:49:13  phil
# Copyright Storm for Mamba
#
# Revision 1.4  2012/03/02 07:11:29  phil
# reflect name change to foundation-sqlite
#
# Revision 1.3  2012/02/28 05:03:57  phil
# Add build of sqlite
#
# Revision 1.2  2011/07/23 02:31:14  phil
# Viper Copyright
#
# Revision 1.1  2011/04/07 17:08:11  phil
# Tracker needs fcgi installed before it will build
#

if [ ! -f "$ROLLSROOT/../../bin/get_sources.sh" ]; then
	echo "To compile this roll on Rocks 6.1.1 or older you need to install a newer rocks-devel rpm.
Install it with:
rpm -Uvh https://googledrive.com/host/0B0LD0shfkvCRRGtadUFTQkhoZWs/rocks-devel-6.2-3.x86_64.rpm
If you need an older version of this roll you can get it from:
https://github.com/rocksclusters-attic"
	exit 1
fi

. $ROLLSROOT/etc/bootstrap-functions.sh || exit 1


# prerequisites for foundation-anaconda
compile_and_install foundation-glib2
compile_and_install foundation-gdk-pixbuf2
compile_and_install foundation-atk
compile_and_install foundation-at-spi2-atk
compile_and_install foundation-gtk+
compile_and_install foundation-glade
compile_and_install foundation-libxklavier
compile_and_install foundation-librsvg

compile fastcgi
install foundation-fcgi
compile sqlite 
install foundation-sqlite

#OSVERSION=$(lsb_release -rs | cut -d . -f 1)
OSVERSION=$(cat /etc/os-release | grep VERSION_ID | cut -d\" -f 2 | cut -d . -f 1)
if [ $OSVERSION == "7" ]; then
	BUILDPKGS="gtk3-devel-docs glib2-doc gobject-introspection-devel glade-devel \
	libgnomekbd-devel libxklavier-devel python-nose libtimezonemap-devel libepoxy-devel lorax itstool" 
	yum -y install $BUILDPKGS
	compile_and_install opt-atk
	compile_and_install opt-glib2
	compile_and_install opt-devel-module
	compile_and_install opt-gtk+
fi
