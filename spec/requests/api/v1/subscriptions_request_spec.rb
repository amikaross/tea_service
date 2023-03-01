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

    expect(Subscription.all.count).to eq(0)

    post '/api/v1/subscriptions', headers: headers, params: JSON.generate(subscription: subscription_params)

    new_subscription = Subscription.last 

    expect(Subscription.all.count).to eq(1)
    expect(new_subscription.customer_id).to eq(customer.id)
    expect(new_subscription.tea_id).to eq(tea.id)
    expect(new_subscription.title).to be_a(String)
    expect(new_subscription.frequency).to be_an(Integer)

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(json_response).to have_key(:data)
    expect(json_response[:data]).to have_key(:type)
    expect(json_response[:data][:type]).to eq("subscription")
    expect(json_response[:data]).to have_key(:id)
    expect(json_response[:data][:id]).to be_a(String)
    expect(json_response[:data]).to have_key(:attributes)
    expect(json_response[:data][:attributes]).to be_a(Hash)

    expect(json_response[:data][:attributes]).to have_key(:customer_id)
    expect(json_response[:data][:attributes][:customer_id]).to be_an(Integer)

    expect(json_response[:data][:attributes]).to have_key(:tea_id)
    expect(json_response[:data][:attributes][:tea_id]).to be_an(Integer)

    expect(json_response[:data][:attributes]).to have_key(:title)
    expect(json_response[:data][:attributes][:title]).to be_a(String)

    expect(json_response[:data][:attributes]).to have_key(:frequency)
    expect(json_response[:data][:attributes][:frequency]).to be_an(Integer)
  end
end