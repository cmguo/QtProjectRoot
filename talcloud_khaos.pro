TEMPLATE = subdirs

GITHUB_MODULES = \
    QtComposition \
    #qtpromise \
    log4qt \
    #QtJsonSerializer \
    QtEventBus \
    QtRestClient \
    thirdparty \

ROBOT_MODULES = \
    RobotPen \

TAL_GITHUB_MODULES = \
    UiBase \
    TalWeb \
    InkCanvas \
    Geometry \
    Showboard \
    TeachingTools \
    # docConvert

TAL_BUSINESS_MODULES_BASE = \
    EventsLog \
    EventsLog\EventsLogService.pro \
    Assistant/Upgrade \
    Salt/salt/Salt.pro \
    TeachingLib \
    Account \
    Main \

TAL_BUSINESS_MODULES_INTERACT = \
    InteractBase \
    InteractionLib \

TAL_H5_MODULES = \
    XhtHtml/Html.pro \
#    Html \


# githubs
SUBDIRS += $$GITHUB_MODULES
#SUBDIRS += $$ROBOT_MODULES
SUBDIRS += $$TAL_GITHUB_MODULES
SUBDIRS += $$TAL_BUSINESS_MODULES_BASE
SUBDIRS += $$TAL_H5_MODULES
#SUBDIRS += QtApp

#prod_qxkt {
#    SUBDIRS += $$TAL_BUSINESS_MODULES_INTERACT
#}
