TEMPLATE = subdirs

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
    Account \
    Main \

SUBDIRS += \
    XhtHtml/Html.pro \
#    Html \
    # docConvert \

#SUBDIRS += QtApp

#prod_xkt {
#    SUBDIRS -= \
#        RobotPen \
#        InteractBase \
#        InteractionLib \
#}
