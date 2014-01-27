import QtQuick 2.0
import Sailfish.Silica 1.0
import "db.js" as DB
import "mandonet.js" as MANDO

Page {
    id: page
    allowedOrientations: Orientation.All
    Component.onCompleted: {
      //var svg=MANDO.getTuneSVG(tune,type,key,abc);
      //abcdata.text=svg
        console.debug("Loading web svg")
    }
    property string svg
    property int id
    property string url
    property string tune
    property string type
    property string abc
    property string key
    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Save Tune"
                onClicked: DB.addCollection(id, tune, url, type, key, abc)
            }
            MenuItem {
                text: "Return To Collection"
                onClicked: {
                    pageStack.clear()
                    pageStack.push('CollectionPage.qml')
                }
            }
            MenuItem {
                text: "Search For Tune"
                onClicked: pageStack.replace(Qt.resolvedUrl("Query.qml"))
            }
        }


            PageHeader {
                id: pageHeader
                title: tune+" "+type
            }
            Label {
                id: tuneKey
                x: Theme.paddingLarge
                text: key + '(' + type + ')'
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
                anchors.top: pageHeader.bottom
            }
            TextArea {
                id: abcdata
                text: abc
                width: page.width
                anchors.top: tuneKey.bottom
            }
    }
}
