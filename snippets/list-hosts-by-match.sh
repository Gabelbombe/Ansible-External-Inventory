#!/bin/bash
ansible 'tag_Function_cms*:tag_Function_ngc*:!tag_Function_*engine*:&tag_Environment_[dD]emo' --list-hosts
#  $ ansible-playbook playbooks/agentrun.yml -l "tag_Function_[cms|ngc]*:&tag_Environment_[d|D]emo" -u ${LDAP} --list-hosts
#
#  playbook: playbooks/agentrun.yml
#
#    play #1 (all): host count=16
#      10.221.0.158
#      10.221.140.168
#      10.221.132.186
#      10.221.132.100
#      10.221.10.39
#      10.221.27.62
#      10.221.142.18
#      10.221.46.68
#      10.221.133.183
#      10.221.138.42
#      10.221.140.227
#      10.221.139.32
#      10.221.135.240
#      10.221.139.224
#      10.221.140.78
#      10.221.137.50