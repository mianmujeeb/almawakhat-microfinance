# Generated by Django 4.0.4 on 2022-07-25 10:18

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('finance', '0009_alter_applicantproductchallan_applicant'),
    ]

    operations = [
        migrations.AlterField(
            model_name='applicantproductchallan',
            name='payable_after_due_date',
            field=models.IntegerField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='applicantproductchallan',
            name='payable_till_due_date',
            field=models.IntegerField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='applicantproductchallan',
            name='principal_outstanding_amount',
            field=models.IntegerField(blank=True, null=True),
        ),
    ]
