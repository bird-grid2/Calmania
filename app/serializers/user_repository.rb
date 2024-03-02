module UserRepository
  # @returns User
  def find_for_jwt_authentication(sub)
    User.find_by(id: sub)
  end
end
