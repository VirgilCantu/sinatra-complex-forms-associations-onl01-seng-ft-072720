class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    if !params[:owner_id] && params[:owner_name]
      @owner = Owner.create(name: params[:owner_name])
      @pet = Pet.create(name: params[:pet_name], owner_id: @owner.id)
    else
      @pet = Pet.create(name: params[:pet_name], owner_id: params[:owner_id])
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end


  patch '/pets/:id' do
    binding.pry
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name])
     if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
      @pet.save
      else 
      @pet.update(owner_id: params[:pet][:owner])
    end
    redirect to "pets/#{@pet.id}"
  end

end