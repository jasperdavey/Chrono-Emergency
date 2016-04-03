console.log('Loading event');
var AWS = require('aws-sdk');
var dynamodb = new AWS.DynamoDB();

exports.handler = function(event, context) {
    console.log("Request received:\n", JSON.stringify(event));
    console.log("Context received:\n", JSON.stringify(context));

    var tableName = "users";
    var tableName1= "activity";
    dynamodb.putItem({
            "TableName": tableName,
            "Item": {
                "email": {
                    "S": event.email
                }, 
                "firstname": {
                    "S": event.firstname
                },
                "lastname": {
                    "S": event.lastname
                },
                "phonenumber": {
                    "N": event.phonenumber
                },
                "gender": {
                    "S": event.gender
                },
                "password": {
                    "S": event.password
                }
            }
        }, function(err, data) {
            if (err) {
                context.fail('ERROR: Dynamo failed: ' + err);
            } else {
                console.log('Dynamo Success: ' + JSON.stringify(data, null, '  '));
                context.succeed('SUCCESS');
            }
        });
        // adding dummy record in activity tabel 
        
         dynamodb.putItem({
            "TableName": tableName1,
            "Item": {
                "email": {
                    "S": event.email
                }, 
                "phonenumber": {
                    "N": event.phonenumber
                }           }
        }, function(err, data) {
            if (err) {
                context.fail('ERROR: Dynamo failed: ' + err);
            } else {
                console.log('Dynamo Success: ' + JSON.stringify(data, null, '  '));
                context.succeed('SUCCESS');
            }
        });
}