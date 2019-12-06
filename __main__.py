#!/usr/bin/python3
#
# Copyright 2019 Sylvia van Os
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import json
import os

from flask import Flask, render_template, request, redirect, url_for, jsonify
from mycroft_bus_client import MessageBusClient, Message

app = Flask(__name__)


class MessageHandler():
    messages = []
    client = MessageBusClient(host=os.environ['MYCROFT_HOST'])

    @staticmethod
    def initialize():
        MessageHandler.client.on('speak', MessageHandler._receive_message)
        MessageHandler.client.run_in_thread()

    @staticmethod
    def _receive_message(message):
        MessageHandler.messages.append(json.loads(message.serialize()))

    @staticmethod
    def send_message(message):
        MessageHandler.client.emit(Message('recognizer_loop:utterance', {"utterances": [message], "lang": "en"}))

    @staticmethod
    def get_messages():
        return MessageHandler.messages


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/messages')
def messages():
    return jsonify(MessageHandler.get_messages())


@app.route('/send_message', methods=['POST'])
def send_message():
    MessageHandler.send_message(request.form['message'])
    return redirect(url_for('index'))


if __name__ == '__main__':
    MessageHandler.initialize()
    app.run()
