from datetime import date
from datetime import datetime

profit_sharing_start_date = '2021-10'
profit_sharing_start_date = profit_sharing_start_date + '-01'
profit_sharing_start_date_formatted = datetime.strptime(
    profit_sharing_start_date, '%Y-%m-%d')

print(profit_sharing_start_date_formatted)

# end_date = '2021-08-04 23:59:59.999999'

# print(datetime.now())


# def get_fundraising_countdown():
#     input_date = "2021-08-05"
#     end_date = "2021-08-04"
#     input_date_format = datetime.strptime(input_date, '%Y-%m-%d')
#     end_date_format = datetime.strptime(end_date, '%Y-%m-%d')
#     input_datetime = datetime.combine(input_date_format, datetime.min.time())
#     end_datetime = datetime.combine(end_date_format, datetime.max.time())

#     difference = end_datetime - input_datetime
#     days, hours, minutes = difference.days, difference.seconds // 3600, difference.seconds // 60 % 60
#     countdown = {
#         "days": days,
#         "hours": hours,
#         "minutes": minutes
#     }
#     return countdown


# res = get_fundraising_countdown()
# print(res)

# d = {'4-4': '50', '4-5': '50', '4-6': '', 'wallet_address': '0x6b45771c0502bA39f933D1037cB4f59B635eb906',
#      'signature': '0x11edd3e993b4675d6a80a40614875a6aedb73388b23bff26cb6c2ff728dc51176a2105a85e21ebf07eb13fd3802a0267ac042faf17eb7bfde1f456ca45ed29c11b', 'amount': '100', 'sigNonce': '1628443798'}

# indexes = list(d)
# for i in indexes[:-4]:
#     print(i[2:])
