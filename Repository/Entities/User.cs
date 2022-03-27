namespace Repository.Entities
{
    public class User
    {
        public int Id { get; set; }

        public IEnumerable<MovieRating> MovieRatings { get; set; }
    }
}
