from django.db import models

# Create your models here.

class Currency(models.Model):
    STAUTS_CHOICES = (
        (1, 'Active'),
        (2, 'Inactive'),
    )
    POSITION_CHOICES = (
        (1, 'Before'),
        (2, 'After'),
    )
    
    status = models.IntegerField(choices=STAUTS_CHOICES, default=1)
    name = models.CharField(max_length=30)
    code = models.CharField(max_length=5)
    symbol = models.CharField(max_length=20)
    position = models.IntegerField(choices=POSITION_CHOICES)
    fractional_units = models.CharField(max_length=20)
    

    class Meta:

        verbose_name = 'Currency'
        verbose_name_plural = 'Currencies'
        db_table = 'Currencies'

    def __str__(self):
        return self.name




class Region(models.Model):
    STAUTS_CHOICES = (
        (1, 'Active'),
        (2, 'Inactive'),
    )
    
    status = models.IntegerField(choices=STAUTS_CHOICES, default=1)
    name = models.CharField(max_length=50)
    code_digit = models.CharField(max_length=10)
    code_alpha = models.CharField(max_length=10)

    class Meta:

        verbose_name = 'Region'
        verbose_name_plural = 'Regions'
        db_table = 'Regions'

    def __str__(self):
        return self.name
    
    

class Country(models.Model):
    STAUTS_CHOICES = (
        (1, 'Active'),
        (2, 'Inactive'),
    )
    
    status = models.IntegerField(choices=STAUTS_CHOICES, default=1)
    name = models.CharField(max_length=50)
    iso2digit = models.CharField(max_length=2)
    iso3digit = models.CharField(max_length=3)
    calling_code = models.CharField(max_length=10)
    latitude = models.CharField(max_length=20)
    longitude = models.CharField(max_length=20)
    timezone = models.CharField(max_length=50)
    currency = models.ForeignKey(Currency, on_delete=models.CASCADE)
    region = models.ForeignKey(Region, on_delete=models.CASCADE, related_name='regions')

    class Meta:

        verbose_name = 'Country'
        verbose_name_plural = 'Countries'
        db_table = 'Countries'

    def __str__(self):
        return self.name



class State(models.Model):
    STAUTS_CHOICES = (
        (1, 'Active'),
        (2, 'Inactive'),
    )
    
    status = models.IntegerField(choices=STAUTS_CHOICES, default=1)
    name = models.CharField(max_length=50)
    latitude = models.CharField(max_length=20)
    longitude = models.CharField(max_length=20)
    code_digit = models.CharField(max_length=5)
    code_alpha = models.CharField(max_length=5)
    country = models.ForeignKey(Country, on_delete=models.CASCADE, related_name='states')
    
    class Meta:

        verbose_name = 'State'
        verbose_name_plural = 'States'
        db_table = 'States'

    def __str__(self):
        return self.name




class SubState(models.Model):
    STAUTS_CHOICES = (
        (1, 'Active'),
        (2, 'Inactive'),
    )
    
    status = models.IntegerField(choices=STAUTS_CHOICES, default=1)
    name = models.CharField(max_length=50)
    latitude = models.CharField(max_length=20)
    longitude = models.CharField(max_length=20)
    state = models.ForeignKey(State, on_delete=models.CASCADE, related_name='sub_states')
    country = models.ForeignKey(Country, on_delete=models.CASCADE, related_name='sub_states')

    class Meta:

        verbose_name = 'Sub State'
        verbose_name_plural = 'Sub States'
        db_table = 'Sub States'

    def __str__(self):
        return self.name



class City(models.Model):
    STAUTS_CHOICES = (
        (1, 'Active'),
        (2, 'Inactive'),
    )
    
    status = models.IntegerField(choices=STAUTS_CHOICES, default=1)
    name = models.CharField(max_length=50)
    latitude = models.CharField(max_length=20)
    longitude = models.CharField(max_length=20)
    code_digit = models.CharField(max_length=5)
    code_alpha = models.CharField(max_length=5)
    sub_state = models.ForeignKey(SubState, on_delete=models.CASCADE, related_name='cities')
    state = models.ForeignKey(State, on_delete=models.CASCADE, related_name='cities')
    country = models.ForeignKey(Country, on_delete=models.CASCADE, related_name='cities')

    class Meta:

        verbose_name = 'City'
        verbose_name_plural = 'Cities'

    def __str__(self):
        return self.name




