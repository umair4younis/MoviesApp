using Moq;
using Business.Interfaces;
using Repository.Interfaces;

namespace Business.Tests.UserService
{
    public class UserServiceBase
    {
        protected readonly Mock<IUserRepository> MockUserRepository;

        public UserServiceBase()
        {
            MockUserRepository = new Mock<IUserRepository>();
        }

        public IUserService GetService()
        {
            return new Business.UserService(MockUserRepository.Object);
        }
    }
}
