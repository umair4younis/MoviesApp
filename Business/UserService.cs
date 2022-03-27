using Business.Interfaces;
using Repository.Interfaces;

namespace Business
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;

        public UserService(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public async Task<bool> UserExistsAsync(int userId)
        {
            if (userId <= 0)
            {
                throw new ArgumentException("userId must be greater than zero", "userId");
            }

            return await _userRepository.UserExistsAsync(userId);
        }
    }
}
