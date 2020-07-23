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
    InteractBase \
    TalWeb \

SUBDIRS += \
    InkCanvas \
    Geometry \
    Showboard \
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
    XhtHtml/Html.pro \
    Html \
    RobotPen \
    # docConvert \

#SUBDIRS += QtApp

prod_xkt {
    SUBDIRS -= \
        RobotPen \
        InteractBase \
        InteractionLib \
}
