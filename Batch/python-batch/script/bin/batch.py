import json
import requests
from argparse import ArgumentParser

def get_option():
    argparser = ArgumentParser()
    argparser = add_argument("-whu", "--webhookurl", type=string,
                             default="", help="Webhook URL")

    return argparser.parse_args()

def post_to_slack(whu, text):
    SLACK_URL = "https://hooks.slack.com/services/{}"

    json_data = {
        "text": text,
    }

    requests.post(SLACK_URL.format(whu), json.dumps(json_data))

if __name == "__main__" :
    args = get_option()
    
    text = "batch finished."

    post_to_slack(args.whu, text)
