using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo2026.Model
{
    public partial class User
    {
        public string Login { get; set; } = null!;
        public string? Password { get; set; }
        public string? Role { get; set; } = null!;
        public string? FirstName { get; set; }
        public string? MiddleName { get; set; }
        public string LastName { get; set; } = null!;
    }
}
