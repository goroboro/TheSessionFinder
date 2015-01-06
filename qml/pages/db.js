//db.js
.import QtQuick.LocalStorage 2.0 as LS
// First, let's create a short helper function to get the database connection
function getDatabase() {
    return LS.LocalStorage.openDatabaseSync("TheSessionFinder", "0.1", "StorageDatabase", 100000);
}

// At the start of the application, we can initialize the tables we need if they haven't been created yet
function initialize() {
    var db = getDatabase();
    db.transaction(
                function(tx) {
                    // Create the collections table if it doesn't already exist
                    // If the table exists, this is skipped
                    tx.executeSql('CREATE TABLE IF NOT EXISTS collections(uid INTEGER UNIQUE, tune TEXT, url TEXT, type TEXT, key TEXT, abc TEXT)');
                });
}

// This function is used to write tune into the database
function addCollection(id,tune,url,type,key,abc) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO collections VALUES (?,?,?,?,?,?);', [id,tune,url,type,key,abc]);
        if (rs.rowsAffected > 0) {
            res = "OK";
            console.log ("Saved to database:"+tune+" "+url+" "+type+" "+key);
        } else {
            res = "Error";
            console.log ("Error saving to database");
        }
    }
    );
    // The function returns “OK” if it was successful, or “Error” if it wasn't
    return res;
}

//This function to remove an item from the database
function delCollection(id) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('DELETE FROM collections WHERE collections.uid=(?);',id);
        if (rs.rowsAffected > 0) {
            res = "OK";
            console.log ("Deleted tune with id:"+id);
        }
        else{
            res = "Error";
            console.log ("Error deleting tune");
        }
    });
    return res;
}

// This function is used to retrieve tune collection from database
function getCollection() {
    var db = getDatabase();
    var respath="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM collections ORDER BY collections.uid DESC;');
        for (var i = 0; i < rs.rows.length; i++) {
            collectionPage.addCollection(rs.rows.item(i).uid,rs.rows.item(i).url,rs.rows.item(i).tune,rs.rows.item(i).type,rs.rows.item(i).key,rs.rows.item(i).abc)
            //console.debug("Getting Collection:" + rs.rows.item(i).tune)
        }
        //if (rs.rows.length==0){
        //    console.debug("No Items in database... returning faux item...")
        //    collectionPage.addCollection('23302','http://thesession.org/tunes/13318','Harry Gidley\'s','waltz','Cmajor','G | cBc | EDC | cBc | D3 |BAG | BAG| BAG | E2G | cBc | EDC | cBc | D3 | BAG | BAG | FED | C3 ||G3 | E3 | A3 | F3 | F2F | D2A | A2G | E3 |G3 | E3 | F3 | A2A | BAG | FED | CEG | c2 ||')
        //}
    })
}
