################################################################################
#
# openocd
#
################################################################################

OPENOCD_VERSION = f93ede5401c711e55d9852986aa399c0318efb22
OPENOCD_SITE = git://github.com/riscv/riscv-openocd
OPENOCD_SITE_METHOD=git

OPENOCD_LICENSE = GPL-2.0+
OPENOCD_LICENSE_FILES = COPYING

define HOST_OPENOCD_CONFIGURE_CMDS
	(cd $(@D); \
	git clone -b 0.76 https://github.com/msteveb/jimtcl; \
	./bootstrap; \
	./configure \
		--oldincludedir=$(STAGING_DIR)/usr/include \
		--includedir=$(HOST_DIR)/include \
		--prefix=$(HOST_DIR) \
		--disable-werror \
	)
endef

define HOST_OPENOCD_BUILD_CMDS
	(cd $(@D); \
	make -j 4 -s LDFLAGS=$(HOST_LDFLAGS); \
	make install \
	)
endef

# Rely on the Config.in options of each individual adapter selecting
# the dependencies they need.

HOST_OPENOCD_DEPENDENCIES = host-libftdi host-libusb host-libusb-compat

$(eval $(generic-package))
$(eval $(host-generic-package))
