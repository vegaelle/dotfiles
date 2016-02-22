#!/usr/bin/python

import sys
import gtk
import gnomekeyring as gkey
import re
#import subprocess
#import getpass

class Keyring(object):
    def __init__(self, name, server, protocol):
        self._name = name
        self._server = server
        self._protocol = protocol
        self._keyring = gkey.get_default_keyring_sync()

    def has_credentials(self):
        try:
            attrs = {"server": self._server, "protocol": self._protocol}
            items = gkey.find_items_sync(gkey.ITEM_NETWORK_PASSWORD, attrs)
            return len(items) > 0
        except gkey.DeniedError:
            return False

    def get_credentials(self):
        attrs = {"server": self._server, "protocol": self._protocol}
        items = gkey.find_items_sync(gkey.ITEM_NETWORK_PASSWORD, attrs)
        return (items[0].attributes["user"], items[0].secret)

    def set_credentials(self, (user, pw)):
        attrs = {
                "user": user,
                "server": self._server,
                "protocol": self._protocol,
            }
        gkey.item_create_sync(gkey.get_default_keyring_sync(),
                gkey.ITEM_NETWORK_PASSWORD, self._name, attrs, pw, True)

def get_username(server):
    keyring = Keyring("offlineimap", server, "imap")
    (username, password) = keyring.get_credentials()
    return username

def get_password(server):
    keyring = Keyring("offlineimap", server, "imap")
    (username, password) = keyring.get_credentials()
    return password

#def get_username(server):
#    return server
#
#def get_password(server):
#    pw = subprocess.Popen(['pwsafe', '-pEq', server], stdin=subprocess.PIPE,
#                                                      stdout=subprocess.PIPE,
#                                                      stderr=subprocess.PIPE)
#    result = pw.communicate(input=master_pw)
#    passwd = result[0].split('\n')[1]
#    return passwd

def oimaptransfolder_gordon(foldername):
    if(foldername == "INBOX"):
        retval = "gordon"
    else:
        retval = "gordon." + foldername
    retval = re.sub("/", ".", retval)
    return retval

def localtransfolder_gordon(foldername):
    if(foldername == "gordon"):
        retval = "INBOX"
    else:
        # remove leading '.gordon'
        retval = re.sub("gordon\.", "", foldername)
    retval = re.sub("\.", "/", retval)
    return retval


def oimaptransfolder_gordontesos(foldername):
    if(foldername == "INBOX"):
        retval = "gordontesos"
    else:
        # retval = "gordontesos." + foldername
        retval = foldername
    # retval = re.sub("/", ".", retval)
    return retval

def localtransfolder_gordontesos(foldername):
    if(foldername == "gordontesos"):
        retval = "INBOX"
    else:
        # remove leading '.gordontesos'
        retval = re.sub("gordontesos\.", "", foldername)
    # retval = re.sub("\.", "/", retval)
    return retval

def oimaptransfolder_ndn(foldername):
    if(foldername == "INBOX"):
        retval = "ndn"
    else:
        retval = "ndn." + foldername
    retval = re.sub("/", ".", retval)
    return retval

def localtransfolder_ndn(foldername):
    if(foldername == "ndn"):
        retval = "INBOX"
    else:
        # remove leading '.ndn'
        retval = re.sub("ndn\.", "", foldername)
    retval = re.sub("\.", "/", retval)
    return retval


def oimaptransfolder_opcheese(foldername):
    if(foldername == "INBOX"):
        retval = "opcheese"
    else:
        retval = "opcheese." + foldername
    # retval = re.sub("/", ".", retval)
    return retval

def localtransfolder_opcheese(foldername):
    if(foldername == "opcheese"):
        retval = "INBOX"
    else:
        # remove leading '.opcheese'
        retval = re.sub("opcheese\.", "", foldername)
    # retval = re.sub("\.", "/", retval)
    return retval

#try:
#    master_pw
#except NameError:
#    master_pw = getpass.getpass('Please enter master password: ')
