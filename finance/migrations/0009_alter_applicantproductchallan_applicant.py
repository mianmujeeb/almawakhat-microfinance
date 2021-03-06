# Generated by Django 4.0.4 on 2022-07-25 08:00

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('applicants', '0013_delete_applicantproduct'),
        ('finance', '0008_alter_applicantproductchallan_applicant_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='applicantproductchallan',
            name='applicant',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='challans_by_applicant', to='applicants.applicant'),
        ),
    ]
