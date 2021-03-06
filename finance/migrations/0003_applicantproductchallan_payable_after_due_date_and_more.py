# Generated by Django 4.0.4 on 2022-07-22 12:00

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('finance', '0002_emichallanparticular'),
    ]

    operations = [
        migrations.AddField(
            model_name='applicantproductchallan',
            name='payable_after_due_date',
            field=models.IntegerField(default=1),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='applicantproductchallan',
            name='payable_till_due_date',
            field=models.IntegerField(default=1),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='applicantproductchallan',
            name='principal_outstanding_amount',
            field=models.IntegerField(default=1),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='applicantproductchallan',
            name='reference_numebr',
            field=models.CharField(default=1, max_length=999),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='applicantproductchallan',
            name='voucher_numebr',
            field=models.CharField(default=1, max_length=999),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='applicantproductchallandetail',
            name='amount',
            field=models.IntegerField(default=1),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='applicantproductchallandetail',
            name='particular',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to='finance.emichallanparticular'),
            preserve_default=False,
        ),
    ]
