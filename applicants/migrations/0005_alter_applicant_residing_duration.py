# Generated by Django 4.0.4 on 2022-06-28 07:13

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('applicants', '0004_rename_cnic_photo_applicantguarantor_cnic_photo_back_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='applicant',
            name='residing_duration',
            field=models.IntegerField(),
        ),
    ]
