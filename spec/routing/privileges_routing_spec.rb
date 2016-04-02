require 'rails_helper'

describe PrivilegesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get('/privileges')).to route_to('privileges#index')
    end

    it 'routes to #new' do
      expect(get('/privileges/new')).to route_to('privileges#new')
    end

    it 'routes to #show' do
      expect(get('/privileges/1')).to route_to('privileges#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get('/privileges/1/edit')).to route_to('privileges#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post('/privileges')).to route_to('privileges#create')
    end

    it 'routes to #update' do
      expect(put('/privileges/1')).to route_to('privileges#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete('/privileges/1')).to route_to('privileges#destroy', id: '1')
    end
  end
end
