using Repository.Interfaces;

namespace Repository
{
    public class UserRepository : BaseRepository, IUserRepository
    {
        public UserRepository(Context context) : base(context) { }

        public async Task<bool> UserExistsAsync(int userId)
        {
            return await Task.Run(() => _context.UserDbSet.Any(u => u.Id == userId));
        }
    }
}
