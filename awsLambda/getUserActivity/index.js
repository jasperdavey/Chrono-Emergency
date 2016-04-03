console.log('Loading event');
var AWS = require('aws-sdk');
var dynamodb = new AWS.DynamoDB();

exports.handler = function(event, context) {
  console.log("Request received:\n", JSON.stringify(event));
  console.log("Context received:\n", JSON.stringify(context));

  var tableName = "activity";
  dynamodb.putItem({
          "TableName": tableName,
          "Item": {
              "email": {
                  "S": event.email
              }, 
              "latitude": {
                  "S": event.latitude
              },
              "longitude": {
                  "S": event.longitude
              },
              "phonenumber": {
                  "N": event.phonenumber
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
}