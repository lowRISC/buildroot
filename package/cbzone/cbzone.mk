################################################################################
#
# cbzone
#
################################################################################

CBZONE_VERSION = 1.0
CBZONE_SOURCE = master.zip
CBZONE_SITE = https://github.com/jrrk/cbzone/archive

define CBZONE_EXTRACT_CMDS
        $(RM) -r $(@D)/cbzone-master
        $(UNZIP) -d $(@D) $(CBZONE_DL_DIR)/$(CBZONE_SOURCE)
        mv $(@D)/cbzone-master/* $(@D)
        $(RM) -r $(@D)/cbzone-master
endef

define CBZONE_BUILD_CMDS
    $(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS)
endef

define CBZONE_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/var/tmp
	$(INSTALL) -D -m 0755 $(@D)/cbzone $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/cbzone.{help,motd} $(TARGET_DIR)/var/tmp
endef

$(eval $(generic-package))
