from flask import Flask, request
from twilio.twiml.messaging_response import MessagingResponse

#import sys
import requests
import json

app = Flask(__name__)

@app.route("/sms", methods =['POST'])
def sms():
    #number = request.form['From']
    message_body = request.form['Body']

    coord = message_body.split()

    lat = coord[0]
    long = coord[1]

    # make API call
    url = f"http://api.avalanche.ca/forecasts/en/products/point?lat={lat}&long={long}"
    response = requests.get(url)
    data = json.loads(response.text)
    report = data['report']

    # extract data
    day1 = report['dangerRatings'][0]['date']['display']
    day1_alp = report['dangerRatings'][0]['ratings']['alp']['rating']['display']
    day1_tln = report['dangerRatings'][0]['ratings']['tln']['rating']['display']
    day1_btl = report['dangerRatings'][0]['ratings']['btl']['rating']['display']

    day2 = report['dangerRatings'][1]['date']['display']
    day2_alp = report['dangerRatings'][1]['ratings']['alp']['rating']['display']
    day2_tln = report['dangerRatings'][1]['ratings']['tln']['rating']['display']
    day2_btl = report['dangerRatings'][1]['ratings']['btl']['rating']['display']

    day3 = report['dangerRatings'][2]['date']['display']
    day3_alp = report['dangerRatings'][2]['ratings']['alp']['rating']['display']
    day3_tln = report['dangerRatings'][2]['ratings']['tln']['rating']['display']
    day3_btl = report['dangerRatings'][2]['ratings']['btl']['rating']['display']

    # print result
    response_message = day1[:3] + day1_alp[:3] + day1_tln[:3] + day1_btl[:3] + day2[:3] + day2_alp[:3] + day2_tln[:3] + day2_btl[:3] + day3[:3] + day3_alp[:3] + day3_tln[:3] + day3_btl[:3]

    resp = MessagingResponse()
    #response_message = 'Hello {}, You said:{}'.format(number, message_body)
    resp.message(response_message)

    return str(resp)

if __name__ == "__main__":
    app.run(debug=True)