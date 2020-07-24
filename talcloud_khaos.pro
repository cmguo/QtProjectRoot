TEMPLATE = subdirs

include($$PWD/config.pri)

SUBDIRS += \
    QtComposition \
    #qtpromise \
    log4qt \
    #QtJsonSerializer \
    QtEventBus \
    QtRestClient \
    thirdparty \

SUBDIRS += \
    UiBase \
    InteractBase \
    TalWeb \

SUBDIRS += \
    InkCanvas \
    Geometry \
    ShowBoard \
    TeachingTools \

SUBDIRS += \
    EventsLog \
    EventsLog\EventsLogService.pro \
    Assistant/Upgrade \

SUBDIRS += \
    Salt/salt/Salt.pro \
    TeachingLib \
    InteractionLib \
    Account \
    Main \

SUBDIRS += \
    Html \
    RobotPen \
    # docConvert \

#SUBDIRS += QtApp

prod_xkt {
    SUBDIRS -= \
        RobotPen \
        InteractBase \
        InteractionLib \

    SUBDIRS = $$replace(SUBDIRS,Html,XhtHtml/Html.pro)
}
