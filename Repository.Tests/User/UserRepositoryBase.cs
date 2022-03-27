﻿using NUnit.Framework;
using repo = Repository.Entities;

namespace Repository.Tests.User
{
    public class UserRepositoryBase : TestRepositoryBase
    {
        protected UserRepository GetRepository()
        {
            return new UserRepository(GetContext());
        }

        [SetUp]
        protected new void Setup()
        {
            base.Setup();
            InsertUser();
        }

        private void InsertUser()
        {
            using (var context = GetContext())
            {
                var user = new repo.User();
                context.Add(user);
                context.SaveChanges();
            }
        }
    }
}
