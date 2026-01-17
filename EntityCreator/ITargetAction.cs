using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntityCreator
{
    public interface ITargetAction
    {
        void Execute(Target target);
    }
}
