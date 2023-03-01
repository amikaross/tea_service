require 'rails_helper'

RSpec.describe 'Subscriptions Requests' do 
  it 'can create a subscription for a customer' do 
    customer = create(:customer)
    tea = create(:tea)
    subscription_params = {
                            tea_id: tea.id,
                            customer_id: customer.id,
                            title: "#{tea.title} subscription",
                            frequency: 2,
                            price: 6.50
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
    expect(new_subscription.status).to eq('active')
    expect(new_subscription.price).to be_a(Float)

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

    expect(json_response[:data][:attributes]).to have_key(:status)
    expect(json_response[:data][:attributes][:status]).to eq('active')

    expect(json_response[:data][:attributes]).to have_key(:price)
    expect(json_response[:data][:attributes][:price]).to be_a(Float)
  end

  it 'returns an error message if the subscription is missing attributes' do 
    customer = create(:customer)
    tea = create(:tea)
    subscription_params = {
                            tea_id: tea.id,
                            customer_id: customer.id,
                            title: "#{tea.title} subscription"
                          }
    headers = {"CONTENT_TYPE" => "application/json"}

    expect(Subscription.all.count).to eq(0)

    post '/api/v1/subscriptions', headers: headers, params: JSON.generate(subscription: subscription_params)

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(Subscription.all.count).to eq(0)
    expect(response.status).to eq(400)
    expect(json_response[:message]).to eq("Record is missing one or more attributes")
    expect(json_response[:errors]).to eq(["Price can't be blank", "Frequency can't be blank"])
  end

  it 'returns an error if you try to create a subscription for a customer or tea that does not exist' do 
    subscription_params = {
      tea_id: 1,
      customer_id: 1,
      title: "New subscription",
      frequency: 2,
      price: 6.50
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    expect(Subscription.all.count).to eq(0)

    post '/api/v1/subscriptions', headers: headers, params: JSON.generate(subscription: subscription_params)
    
    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(Subscription.all.count).to eq(0)
    expect(response.status).to eq(400)
    expect(json_response[:message]).to eq("Record is missing one or more attributes")
    expect(json_response[:errors]).to eq(["Customer must exist", "Tea must exist"])
  end

  it 'can cancel a customers tea subscription' do 
    customer = create(:customer)
    tea = create(:tea)
    subscription = create(:subscription, customer: customer, tea: tea)

    expect(subscription.status).to eq('active')

    headers = {"CONTENT_TYPE" => "application/json"}
    subscription_params = {
      status: "cancelled"
    }

    patch "/api/v1/subscriptions/#{subscription.id}", headers: headers, params: JSON.generate(subscription: subscription_params)  

    subscription.reload
    
    expect(response.status).to eq(200)
    expect(subscription.status).to eq('cancelled')
  end

  it 'returns an error message if you try to cancel a subscription that does not exist' do 
    headers = {"CONTENT_TYPE" => "application/json"}
    subscription_params = {
      status: "cancelled"
    }

    patch "/api/v1/subscriptions/10000000", headers: headers, params: JSON.generate(subscription: subscription_params)

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(404)
    expect(json_response[:message]).to eq("No record found")
    expect(json_response[:errors]).to eq(["Couldn't find Subscription with 'id'=10000000"])
  end
end