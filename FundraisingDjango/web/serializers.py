from rest_framework import serializers
from web.models import Test, FundraisingPlan


class TestSerializer(serializers.ModelSerializer):
    class Meta:
        model = Test
        fields = '__all__'
        # fields = ('id', 'song', 'singer', 'last_modify_date', 'created')


class FundraisingSerializer(serializers.ModelSerializer):
    class Meta:
        model = FundraisingPlan
        fields = '__all__'
