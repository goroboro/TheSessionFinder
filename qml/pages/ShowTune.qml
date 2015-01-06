import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3
import "db.js" as DB


Page {
    id: page
    allowedOrientations: Orientation.All
    property string svg
    property int id
    property string url
    property string tune
    property string type
    property string abc
    property string key
    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        id: flickScreen
        //this is an attempt to get flickable handling scrolling... I'm not sure if I am calculating right...
        //but so far works for all the tunes I've found
        contentHeight: myItem.height
        anchors.fill: parent
        PageHeader {
            id: pageHeader
            title: tune+" "+type
        }
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
        Item{
            id: myItem
            width: page.width
            anchors.top: pageHeader.bottom
            height: whiteRect.height+120
            Rectangle {
                id: whiteRect
                color: "white"
                opacity: 0.7
                width: parent.width
                height: childrenRect.height+5
                Label {
                    id: tuneKey
                    x: Theme.paddingLarge
                    text: key
                    color: Theme.secondaryHighlightColor
                    font.pixelSize: Theme.fontSizeSmall
                }
                Image {
                     id: svgimg
                     anchors.top: tuneKey.bottom
                     sourceSize.width: parent.width
                }
                //TextArea {
                //    id: abcdata
                //    text: abc
                //    color: "black"
                //    font.pixelSize: Theme.fontSizeTiny
                //    width: page.width
                //    anchors.top: svgimg.bottom
                //}
            }


            Python {
                id: py

                Component.onCompleted: {
                    // Add the directory of this .qml file to the search path
                    addImportPath(Qt.resolvedUrl('.').substr('file://'.length));

                    // Import the main module and load the data
                    importModule('abc2svg', function () {
                        py.call('abc2svg.get_data', [tune,key,type,abc,id], function(result) {
                            // Load the received data into the list model
                            svgimg.source=result;
                        });
                    });
                }
            }
        }
    }
}
