# Generated by Django 4.0.4 on 2022-07-18 09:33

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('applicants', '0008_applicantproduct_added_by_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='applicantproduct',
            name='installment_start_date',
            field=models.DateTimeField(default=django.utils.timezone.now),
            preserve_default=False,
        ),
    ]
