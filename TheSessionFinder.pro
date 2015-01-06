# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = TheSessionFinder

CONFIG += sailfishapp

SOURCES += src/TheSessionFinder.cpp

OTHER_FILES += qml/TheSessionFinder.qml \
    qml/cover/CoverPage.qml \
    rpm/TheSessionFinder.spec \
    rpm/TheSessionFinder.yaml \
    TheSessionFinder.desktop \
    qml/pages/Query.qml \
    qml/pages/Results.qml \
    qml/pages/TuneInfo.qml \
    qml/pages/ShowTune.qml \
    qml/pages/CollectionPage.qml \
    qml/pages/db.js \
    qml/pages/abc2svg.py

HEADERS +=

