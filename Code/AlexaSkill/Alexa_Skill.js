const Alexa = require('ask-sdk-core');

const LaunchRequestHandler = {
    canHandle(handlerInput) {
        return handlerInput.requestEnvelope.request.type === 'LaunchRequest';
    },
    handle(handlerInput) {
        const speechText = 'Welcome to the ducklab Investments Alexa Skill. If you need help just let me know';
        return handlerInput.responseBuilder
            .speak(speechText)
            .reprompt(speechText)
            .getResponse();
    }
};
const GetGameInfoHandler = {
    canHandle(handlerInput) {
        return handlerInput.requestEnvelope.request.type === 'IntentRequest'
            && handlerInput.requestEnvelope.request.intent.name === 'GetGameInfo';
    },
    async handle(handlerInput) {
        
        const id = handlerInput.requestEnvelope.request.intent.slots.id.value;
        var theFact = "";
        var url = 'https://ducklabinvestments.azurewebsites.net/home/GetGameInfo?userId=' + id;
        var speechOutput = "";
        
        console.log("first");
/*       
        var https = require('https');
        console.log(url);
        var req = https.get(url, (res) => {
          console.log('statusCode:', res.statusCode);
          console.log('headers:', res.headers);
    
          res.on('data', (d) => {
            responseString += d;
          });
    
          res.on('end', function(res) {
            speechOutput = responseString;
            
            console.log('==> Answering: ', speechOutput);
            
          });
        });
        req.end();
        console.log('penis' + speechOutput);*/
        
        await httpsGet(url).then(function(result) {
            console.log('eeeeeee' + result);
            theFact = result;
            console.log('ayyyyy' + theFact);
 
        });
        var test = '"{"games":["balances":[lllll"';
        if (test.length < theFact.length){
            var str = JSON.parse(theFact);
            console.log('json        ' + str);
            var first = str.substring(0, str.indexOf(']')+1);
            var second = str.substring(str.indexOf(']')+1);
            str = first + ',' + second;
            console.log(str);
            var json = JSON.parse(str)
            var name = json.games[0];
            console.log('pleaseework' + name);
            var numGames = json.games.length;
            console.log('fifn       ' + theFact);
            speechOutput = 'You have ' + numGames + ' games currently. Here are your balances. ';
            for(var i = 0; i < numGames; i++){
                speechOutput += ' For the game ' + json.games[i] + ' you have ' + json.balances[i] + ' dollars...';
            }
        }
        else{
            speechOutput = 'You dont have any games currently. Go to the Duck Lab Website to start your first game.'
        }
        return handlerInput.responseBuilder
            .speak(speechOutput)
            .reprompt(speechOutput)
            .getResponse();
        
    }
}


function httpsGet(url) {
        
        return new Promise((resolve, reject) => {
            var https = require('https');
            console.log("f this");
            var speechOutput = "";
            var responseString = "";
            console.log(url);
            
            var req = https.get(url, (res) => {
              console.log('statusCode:', res.statusCode);
              console.log('headers:', res.headers);
            
            
                  res.on('data', (d) => {
                    responseString += d;
                  });
            
                  res.on('end', function(res) {
                    speechOutput = responseString;
                    resolve(speechOutput);
                    console.log('==> Answering: ', speechOutput);
                  });
              
            }).on('error', (e) => {
              reject(console.log(e));
            });
            req.end();
        });
}


const GetNewFactHandler = {
    canHandle(handlerInput) {
        const request = handlerInput.requestEnvelope.request;
        return request.type === 'IntentRequest'
           && request.intent.name === 'GetNewFact';
  },
  handle(handlerInput) {
      
    var data = ['Even though America currently has the biggest stock market, The U.S. did not invent it. The first stock market was started in Antwerp, Belgium, in 1460 ', 
    'Americas first stock exchange was established in Philadelphia in 1790',
    'The first company to list on the New York Stock Exchange was the Bank of New York 1792',
    'Back in 1971 when the NASDAQ was established, it traded only O.T.C. stocks, really just another term for penny stocks',
    'September is known as the poorest performing month in the stock market'];
    
    var random = Math.floor(Math.random() * 5);
    console.log(data[random]);
    var speechOutput = data[random];
    console.log(speechOutput);
    
    return handlerInput.responseBuilder
    .speak(speechOutput)
    .reprompt(speechOutput)
    .getResponse();
  },
};

const GetNewTipHandler = {
    canHandle(handlerInput) {
        const request = handlerInput.requestEnvelope.request;
        return request.type === 'IntentRequest'
           && request.intent.name === 'GetNewTip';
  },
  handle(handlerInput) {
      
    var data = ['Analyzing regular filings public companies make with the Securities and Exchange Commission is useful for deciding on buying and selling certain company stocks',
  'Holding stocks for long periods of time provide dividends which can balance out losses comparing to short term traders',
  'Investing in a profitable stock requires research and timing',
  'Investing in a certain stock can yield higher profits over time comparing to trading stocks in short periods of time',
  'Evaluating cash flow statements can give better insight on company behavior as opposed to income statements'];
    
    var random = Math.floor(Math.random() * 5);
    console.log(data[random]);
    var speechOutput = data[random];
    console.log(speechOutput);
    
    return handlerInput.responseBuilder
    .speak(speechOutput)
    .reprompt(speechOutput)
    .getResponse();
  },
};

const GetStockPriceHandler = {
    canHandle(handlerInput) {
        const request = handlerInput.requestEnvelope.request;
        return request.type === 'IntentRequest'
           && request.intent.name === 'StockPrice';
  },
  handle(handlerInput) {
      
    var speechOutput = 'This skill is already implemeted, Just say Alexa ask me for a... Blank... stock price.';
    
    return handlerInput.responseBuilder
    .speak(speechOutput)
    .getResponse();
  },
};
const HelpIntentHandler = {
    canHandle(handlerInput) {
        return handlerInput.requestEnvelope.request.type === 'IntentRequest'
            && handlerInput.requestEnvelope.request.intent.name === 'AMAZON.HelpIntent';
    },
    handle(handlerInput) {
        const speechText = 'Hello, You can ask for your duck lab game status, but make sure to know your I.D., or you can ask me for some stock advice or interesting facts. If you would like to know a stock price simply ask Alexa';

        return handlerInput.responseBuilder
            .speak(speechText)
            .reprompt(speechText)
            .getResponse();
    }
};
const CancelAndStopIntentHandler = {
    canHandle(handlerInput) {
        return handlerInput.requestEnvelope.request.type === 'IntentRequest'
            && (handlerInput.requestEnvelope.request.intent.name === 'AMAZON.CancelIntent'
                || handlerInput.requestEnvelope.request.intent.name === 'AMAZON.StopIntent');
    },
    handle(handlerInput) {
        const speechText = ' Thank you for using the Duck lab Investments Alexa Skill... Goodbye!';
        return handlerInput.responseBuilder
            .speak(speechText)
            .getResponse();
    }
};
const SessionEndedRequestHandler = {
    canHandle(handlerInput) {
        return handlerInput.requestEnvelope.request.type === 'SessionEndedRequest';
    },
    handle(handlerInput) {
        // Any cleanup logic goes here.
        return handlerInput.responseBuilder.getResponse();
    }
};

// The intent reflector is used for interaction model testing and debugging.
// It will simply repeat the intent the user said. You can create custom handlers
// for your intents by defining them above, then also adding them to the request
// handler chain below.
/*const IntentReflectorHandler = {
    canHandle(handlerInput) {
        return handlerInput.requestEnvelope.request.type === 'IntentRequest';
    },
    handle(handlerInput) {
        const intentName = handlerInput.requestEnvelope.request.intent.name;
        const speechText = `You just triggered ${intentName}`;

        return handlerInput.responseBuilder
            .speak(speechText)
            //.reprompt('add a reprompt if you want to keep the session open for the user to respond')
            .getResponse();
    }
};*/

// Generic error handling to capture any syntax or routing errors. If you receive an error
// stating the request handler chain is not found, you have not implemented a handler for
// the intent being invoked or included it in the skill builder below.
const ErrorHandler = {
    canHandle() {
        return true;
    },
    handle(handlerInput, error) {
        console.log(`~~~~ Error handled: ${error.message}`);
        const speechText = `Sorry, I couldn't understand what you said. Please try again.`;

        return handlerInput.responseBuilder
            .speak(speechText)
            .reprompt(speechText)
            .getResponse();
    }
};


// This handler acts as the entry point for your skill, routing all request and response
// payloads to the handlers above. Make sure any new handlers or interceptors you've
// defined are included below. The order matters - they're processed top to bottom.
exports.handler = Alexa.SkillBuilders.custom()
    .addRequestHandlers(
        LaunchRequestHandler,
        GetGameInfoHandler,
        GetNewFactHandler,
        GetNewTipHandler,
        GetStockPriceHandler,
        HelpIntentHandler,
        CancelAndStopIntentHandler,
        SessionEndedRequestHandler)
        //IntentReflectorHandler) // make sure IntentReflectorHandler is last so it doesn't override your custom intent handlers
    .addErrorHandlers(
        ErrorHandler)
    .lambda();
