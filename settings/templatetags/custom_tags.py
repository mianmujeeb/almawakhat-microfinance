import datetime
from django import template
from django.db.models import Sum
from django.shortcuts import get_object_or_404
from django.contrib.auth.models import Group
from finance.models import *
from django.utils import timezone
from num2words import num2words

register = template.Library()

# List indexing in Django templates
@register.filter
def index(indexable, i):
    return indexable[i]

@register.filter(name='type')
def type(args):
    return type(args)


# Checking for group filter
@register.filter(name='has_group')
def has_group(user, group_name):
    group = Group.objects.get(name=group_name)
    return True if group in user.groups.all() else False


@register.simple_tag
def amount_to_words(amount):
    return num2words(amount)