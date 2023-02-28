require 'rails_helper'

RSpec.describe 'Subscription Requests' do 
  it 'can create a subscription' do 
    customer = create(:customer)
    tea = create(:tea)
    subscription_params = {
                            tea_id: tea.id,
                            customer_id: customer.id,
                            title: "#{tea.title} subscription",
                            frequency: 2
                          }
    headers = {"CONTENT_TYPE" => "application/json"}

    post '/subscriptions', headers: headers, params: JSON.generate(subscription: subscription_params)
    
    new_subscription = Subscription.last 

    expect(Subscription.all.count).to eq(1)
    expect(new_subscription.customer_id).to eq(customer.id)
    expect(new_subscription.tea_id).to eq(tea.id)
    expect(new_subscription.title).to be_a(String)
    expect(new_subscription.frequency).to be_an(Integer)
  end
end