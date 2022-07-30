from django.urls import path
from .views import *


urlpatterns = [
    path('product-categories', productCategories, name="product-categories"),
    path('products', products, name="products"),
    path('product/update/<int:id>', updateProduct, name="update-product"),
]